
overaligned_automatic_boundaries.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<type32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	(%rsp), %rax
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	leaq	(%rsp), %rax
               	movl	$0xa, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	(%rsp), %rax
               	andq	$0x1f, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rsp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x9, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rsp
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	0x60(%rsp), %rcx
               	xorq	%rax, %rax
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	leaq	0x40(%rsp), %rcx
               	movl	$0x2, %edx
               	movb	%dl, (%rcx)
               	leaq	(%rsp), %rcx
               	movl	$0x3, %edx
               	movb	%dl, (%rcx)
               	leaq	0x60(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movq	%rcx, (%rdx)
               	leaq	0x60(%rsp), %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x40(%rsp), %rax
               	andq	$0x1f, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rsp), %rax
               	andq	$0x3f, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x60(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x40(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	-0xa0(%rbp), %rsp
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<at_page>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x20, %rsp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	movq	$0x0, (%rsp)
               	andq	$-0x1000, %rsp          # imm = 0xF000
               	movq	$0x0, (%rsp)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	(%rsp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movb	%dl, (%rax)
               	leaq	(%rsp), %rax
               	movl	$0x2, %edx
               	movb	%dl, 0xfff(%rax)
               	leaq	(%rsp), %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	movsbq	0xfff(%rax), %rax
               	cmpq	$0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	-0x1020(%rbp), %rsp
               	addq	$0x1020, %rsp           # imm = 0x1020
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<over_a_page>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x350, %rsp            # imm = 0x350
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x340, %rsp            # imm = 0x340
               	movq	$0x0, (%rsp)
               	andq	$-0x40, %rsp
               	movq	$0x0, (%rsp)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	(%rsp), %rcx
               	xorq	%rax, %rax
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	leaq	(%rsp), %rcx
               	addq	$0x1000, %rcx           # imm = 0x1000
               	movl	$0x2, %edx
               	movb	%dl, (%rcx)
               	leaq	(%rsp), %rcx
               	addq	$0x2327, %rcx           # imm = 0x2327
               	movl	$0x3, %edx
               	movb	%dl, (%rcx)
               	leaq	(%rsp), %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x1000, %rax           # imm = 0x1000
               	movsbq	(%rax), %rax
               	cmpq	$0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x2327, %rax           # imm = 0x2327
               	movsbq	(%rax), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	-0x2350(%rbp), %rsp
               	addq	$0x2350, %rsp           # imm = 0x2350
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	(%rsp), %rcx
               	xorq	%rax, %rax
               	movl	$0x4, %edx
               	movw	%dx, (%rcx)
               	leaq	(%rsp), %rcx
               	andq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	movswq	(%rax), %rax
               	cmpq	$0x4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	-0xa0(%rbp), %rsp
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x150, %rsp            # imm = 0x150
               	leaq	-0x150(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x150(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	movw	%dx, (%rax)
               	leaq	-0x150(%rbp), %rax
               	movl	$0x2, %edx
               	movw	%dx, 0x7e(%rax)
               	leaq	-0x150(%rbp), %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x150(%rbp), %rax
               	movswq	(%rax), %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x150(%rbp), %rax
               	movswq	0x7e(%rax), %rax
               	cmpq	$0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0xd0(%rbp), %rcx
               	xorq	%rax, %rax
               	movl	$0x7, %edx
               	movq	%rdx, (%rcx)
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, %edx
               	movq	%rdx, 0x18(%rcx)
               	leaq	-0xd0(%rbp), %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0xd0(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0xd0(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %edx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
