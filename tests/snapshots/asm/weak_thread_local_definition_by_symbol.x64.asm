
weak_thread_local_definition_by_symbol.x64:	file format elf64-x86-64

Disassembly of section .text:

<addr_t>:
               	movq	%fs:0x0, %rax
               	addq	$0x0, %rax
		R_X86_64_TPOFF32	tw
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$0x0, %rax
		R_X86_64_TPOFF32	tw
               	movq	(%rax), %rcx
               	addq	$0x4, %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	callq	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$0x0, %rcx
		R_X86_64_TPOFF32	tw
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
