
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
               	subq	$0x10, %rsp
               	movq	(%rip), %rax            # <addr>
		R_X86_64_REX_GOTPCRELX	wobj-0x4
               	movq	(%rax), %rax
               	movq	(%rip), %rcx            # <addr>
		R_X86_64_PC32	.data+0x1c
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	(%rip), %rax            # <addr>
		R_X86_64_REX_GOTPCRELX	ws-0x4
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	(%rip), %rax            # <addr>
		R_X86_64_PC32	.data+0x24
               	callq	*%rax
               	movq	%rax, 0x8(%rsp)
               	callq	<addr>
		R_X86_64_PLT32	wf-0x4
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	addq	%r10, %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
