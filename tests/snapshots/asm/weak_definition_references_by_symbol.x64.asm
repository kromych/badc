
weak_definition_references_by_symbol.x64:	file format elf64-x86-64

Disassembly of section .text:

<wf>:
               	movl	$0x7, %eax
               	retq

<get_f>:
               	leaq	(%rip), %rax            # <addr>
		R_X86_64_PC32	wf-0x4
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	(%rip), %rax            # <addr>
		R_X86_64_REX_GOTPCRELX	wobj-0x4
               	movq	(%rax), %rax
               	leaq	(%rip), %rcx            # <addr>
		R_X86_64_PC32	.data+0x1c
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	(%rip), %rax            # <addr>
		R_X86_64_REX_GOTPCRELX	ws-0x4
               	leaq	0x10(%rax), %rcx
               	cmpq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	(%rip), %rax            # <addr>
		R_X86_64_PC32	.data+0x24
               	movq	(%rax), %rax
               	callq	*%rax
               	movq	%rax, %rbx
               	callq	<addr>
		R_X86_64_PLT32	wf-0x4
               	addq	%rbx, %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
