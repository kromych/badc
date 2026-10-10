
dead_arm_config_predicate_undefined.x64:	file format elf64-x86-64

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

<dispatch>:
               	movq	(%rdi), %rax
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movl	$0x1, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	movq	-0x8(%rbp), %rsi
               	testb	$0x8, %sil
               	je	<addr>
               	addq	%rdx, %rax
               	leaq	0xa(%rax), %rcx
               	movl	$0x2, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0x3, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0x4, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0x5, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0x6, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0x7, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0x8, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0x9, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0xa, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0xb, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0xc, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0xd, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0xe, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	movl	$0xf, %eax
               	movq	%rax, -0x8(%rbp)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rdx
               	movq	-0x8(%rbp), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpl	$0xb0, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
