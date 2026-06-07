
struct_array_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %esi
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpq	$0xb, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x0, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %esi
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpq	$0x0, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	0x10(%rax), %rcx
               	cmpq	$0x1e, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %esi
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movslq	0x14(%rax), %rax
               	cmpq	$0x1f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
