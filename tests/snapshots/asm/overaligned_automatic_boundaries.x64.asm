
overaligned_automatic_boundaries.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<type32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	movl	$0xa, %ecx
               	movl	%ecx, 0x4(%rax)
               	movq	%rax, %rdx
               	andq	$0x1f, %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	(%rax), %rdx
               	cmpl	$0x9, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0xa, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leaq	-0x40(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rdx
               	jmp	<addr>

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	movb	%dl, (%rax)
               	leaq	0x40(%rsp), %rdx
               	movl	$0x2, %esi
               	movb	%sil, (%rdx)
               	leaq	(%rsp), %rsi
               	movl	$0x3, %edi
               	movb	%dil, (%rsi)
               	leaq	<rip>, %rdi
               	movq	%rax, (%rdi)
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0x1f, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rsi, %rax
               	andq	$0x3f, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x60(%rsp), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	0x40(%rsp), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	-0xa0(%rbp), %rsp
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
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
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	movb	%dl, (%rax)
               	movl	$0x2, %edx
               	movb	%dl, 0xfff(%rax)
               	movq	%rax, %rdx
               	andq	$0xfff, %rdx            # imm = 0xFFF
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rdx
               	cmpl	$0x1, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0xfff(%rax), %rax
               	cmpl	$0x2, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	leaq	-0x1020(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rdx
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
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	movb	%dl, (%rax)
               	leaq	0x1000(%rax), %rdx
               	movl	$0x2, %esi
               	movb	%sil, (%rdx)
               	leaq	0x2327(%rax), %rdx
               	movl	$0x3, %esi
               	movb	%sil, (%rdx)
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x1000, %rax           # imm = 0x1000
               	movsbq	(%rax), %rax
               	cmpl	$0x2, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x2327, %rax           # imm = 0x2327
               	movsbq	(%rax), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	-0x2350(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	xorl	%eax, %eax
               	movl	$0x4, %edx
               	movw	%dx, (%rcx)
               	andq	$0x1f, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x148, %rsp            # imm = 0x148
               	pushq	%rbx
               	leaq	-0x140(%rbp), %rax
               	leaq	<rip>, %rbx
               	movq	%rax, (%rbx)
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	movw	%dx, (%rax)
               	movl	$0x2, %edx
               	movw	%dx, 0x7e(%rax)
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movswq	(%rax), %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x140(%rbp), %rax
               	movswq	0x7e(%rax), %rax
               	cmpl	$0x2, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rax
               	movq	%rax, (%rbx)
               	xorl	%ecx, %ecx
               	movl	$0x7, %edx
               	movq	%rdx, (%rax)
               	movl	$0x8, %edx
               	movq	%rdx, 0x18(%rax)
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x8, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	$0x0, (%rbx)
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
