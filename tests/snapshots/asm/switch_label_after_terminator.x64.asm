
switch_label_after_terminator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<outer>:
               	movslq	%edi, %rdi
               	cmpq	$0x2, %rdi
               	jl	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	retq
               	cmpq	$0x1, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %rdi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x65, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x66, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x67, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x63, %edi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
