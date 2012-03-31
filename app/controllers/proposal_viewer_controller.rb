class ProposalViewerController < ApplicationController
  before_filter :load_template, :only => :show

  # GET /proposal_viewer/show/:id
  def show
    @proposal = Proposal.find(params[:id])
    @html = TemplatesManager.render_variables(@template_html, {
      :client_name => @proposal.client.name,
      :client_company => @proposal.client.company,
      :client_website => @proposal.client.website,
      :proposal_name => @proposal.name,
      :proposal_send_date => @proposal.send_date,
      :proposal_user_name => @proposal.user_name,
      :section_header => 'Custom section!!',
      :section_content => 'and this is section content!'
    })
    render :text => @html
  end

  private

  def load_template
    @template_html = STATIC_TEMPLATES["proposal-template"] #we'll going to use proposal template for this controller
  end

end
