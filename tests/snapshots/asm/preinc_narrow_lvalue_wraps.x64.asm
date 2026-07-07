
preinc_narrow_lvalue_wraps.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<preinc_u8_wrap>:
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>

<preinc_u16_wrap>:
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>

<preinc_u32_wrap>:
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>

<compound_u8_wrap>:
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>

<compound_u16_wrap>:
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>

<preinc_u8_through_pointer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0xff, %eax
               	movb	%al, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movzbq	(%rax), %rdx
               	incq	%rdx
               	movb	%dl, (%rax)
               	movzbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movzbq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	orq	$0x0, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	movslq	%ebx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
