
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
               	testl	%ecx, %ecx
               	jne	<addr>
               	movsbq	(%rsp), %rcx
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0xfff(%rsp), %rax
               	cmpl	$0x2, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>

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
               	testl	%edx, %edx
               	jne	<addr>
               	movsbq	(%rsp), %rdx
               	cmpl	$0x1, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
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
               	movq	%rax, %rdx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x180, %rsp            # imm = 0x180
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x1, %ecx
               	movw	%cx, (%rsp)
               	movl	$0x2, %edx
               	movw	%dx, 0x7e(%rsp)
               	testb	$0xf, %al
               	jne	<addr>
               	movswq	(%rsp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	0x120(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x7, 0x120(%rsp)
               	movq	$0x8, 0x138(%rsp)
               	testb	$0xf, %al
               	jne	<addr>
               	movq	0x120(%rsp), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x9, (%rsp)
               	movl	$0xa, 0x4(%rsp)
               	testb	$0x1f, %al
               	jne	<addr>
               	movl	(%rsp), %eax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	0x140(%rsp), %rax
               	movb	$0x1, 0x140(%rsp)
               	leaq	0x100(%rsp), %rcx
               	movb	$0x2, 0x100(%rsp)
               	leaq	(%rsp), %rdx
               	movb	$0x3, (%rsp)
               	movq	%rax, <rip> # <addr>
               	testb	$0xf, %al
               	jne	<addr>
               	testb	$0x1f, %cl
               	jne	<addr>
               	testb	$0x3f, %dl
               	jne	<addr>
               	movsbq	0x140(%rsp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsbq	0x100(%rsp), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movsbq	(%rsp), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
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
               	leaq	0x80(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movw	$0x4, 0x80(%rsp)
               	testb	$0x1f, %al
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
