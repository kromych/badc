
switch_multilabel.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify>:
               	movslq	%edi, %rdi
               	cmpq	$0x42, %rdi
               	jl	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	cmpq	$0x32, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x62, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x31, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x33, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x30, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x31, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x32, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x41, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x33, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x41, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x61, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x63, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x42, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x61, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x62, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x64, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x63, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x64, %rdi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x61, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x62, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x63, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x41, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x42, %edi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x30, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x33, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x3f, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
