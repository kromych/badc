
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
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x9, (%rsp)
               	movl	$0xa, 0x4(%rsp)
               	movq	%rax, %rcx
               	andq	$0x1f, %rcx
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	cmovneq	%rax, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	0x4(%rsp), %eax
               	cmpl	$0xa, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	movb	$0x1, 0x60(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movb	$0x2, 0x40(%rsp)
               	leaq	(%rsp), %rsi
               	movb	$0x3, (%rsp)
               	movq	%rax, <rip> # <addr>
               	andq	$0xf, %rax
               	xorl	%ecx, %ecx
               	andq	$0x1f, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testl	%eax, %eax
               	cmovneq	%rcx, %rdx
               	andq	$0x3f, %rsi
               	testl	%esi, %esi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	cmoveq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	0x60(%rsp), %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	0x40(%rsp), %rax
               	cmpl	$0x2, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rsp), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>

<at_page>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	movq	$0x0, (%rsp)
               	andq	$-0x1000, %rsp          # imm = 0xF000
               	movq	$0x0, (%rsp)
               	leaq	(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movb	$0x1, (%rsp)
               	movb	$0x2, 0xfff(%rsp)
               	movq	%rax, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	testl	%ecx, %ecx
               	cmovneq	%rax, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0xfff(%rsp), %rax
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<over_a_page>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x340, %rsp            # imm = 0x340
               	movq	$0x0, (%rsp)
               	andq	$-0x40, %rsp
               	movq	$0x0, (%rsp)
               	leaq	(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movb	$0x1, (%rsp)
               	leaq	0x1000(%rax), %rcx
               	movb	$0x2, (%rcx)
               	leaq	0x2327(%rax), %rdx
               	movb	$0x3, (%rdx)
               	movq	%rax, %rdx
               	andq	$0x3f, %rdx
               	xorl	%eax, %eax
               	movl	$0x1, %esi
               	testl	%edx, %edx
               	cmovneq	%rax, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	(%rsp), %rax
               	addq	$0x2327, %rax           # imm = 0x2327
               	movsbq	(%rax), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movw	$0x4, (%rsp)
               	andq	$0x1f, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	testl	%eax, %eax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0xa0(%rbp), %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x1, %ecx
               	movw	%cx, -0xa0(%rbp)
               	movl	$0x2, %edx
               	movw	%dx, -0x22(%rbp)
               	testb	$0xf, %al
               	jne	<addr>
               	movswq	-0xa0(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x7, -0x20(%rbp)
               	movq	$0x8, -0x8(%rbp)
               	testb	$0xf, %al
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
