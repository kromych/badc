
preinc_narrow_lvalue_wraps.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<preinc_u8_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xff, %eax
               	xorq	%rdx, %rdx
               	incq	%rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<preinc_u16_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	xorq	%rdx, %rdx
               	incq	%rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<preinc_u32_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	xorq	%rdx, %rdx
               	incq	%rax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<compound_u8_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xf0, %eax
               	xorq	%rdx, %rdx
               	addq	$0x10, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xff, %rax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<compound_u16_wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xfff0, %eax           # imm = 0xFFF0
               	xorq	%rdx, %rdx
               	addq	$0x10, %rax
               	movq	%rax, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rcx
               	cmpq	$0x1, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<preinc_u8_through_pointer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0xff, %eax
               	movb	%al, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	xorq	%rdx, %rdx
               	movzbq	(%rax), %rcx
               	incq	%rcx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edx
               	movslq	%edx, %rax
               	cmpq	$0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
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
               	callq	<addr>
               	orq	%rax, %rbx
               	movslq	%ebx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
