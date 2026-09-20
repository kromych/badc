
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
               	xorl	%edx, %edx
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	movq	(%rax), %rdi
               	testb	$0x8, %dil
               	je	<addr>
               	addq	%rsi, %rcx
               	leaq	0xa(%rcx), %rdx
               	movl	$0x2, %ecx
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	(%rax), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movl	$0x3, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	leaq	0xa(%rcx), %rsi
               	movq	(%rax), %rcx
               	testb	$0x8, %cl
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	leaq	0xa(%rcx), %rsi
               	movq	(%rax), %rcx
               	testb	$0x8, %cl
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	(%rax), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movl	$0x6, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	leaq	0xa(%rcx), %rsi
               	movq	(%rax), %rcx
               	testb	$0x8, %cl
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movl	$0x7, %ecx
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	leaq	0xa(%rcx), %rsi
               	movq	(%rax), %rcx
               	testb	$0x8, %cl
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movl	$0x8, %ecx
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	(%rax), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movl	$0x9, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	leaq	0xa(%rcx), %rsi
               	movq	(%rax), %rcx
               	testb	$0x8, %cl
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movl	$0xa, %ecx
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	leaq	0xa(%rcx), %rsi
               	movq	(%rax), %rcx
               	testb	$0x8, %cl
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movl	$0xb, %ecx
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	(%rax), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movl	$0xc, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	leaq	0xa(%rcx), %rsi
               	movq	(%rax), %rcx
               	testb	$0x8, %cl
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	leaq	0xa(%rcx), %rsi
               	movq	(%rax), %rcx
               	testb	$0x8, %cl
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movl	$0xe, %ecx
               	movq	%rcx, (%rax)
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	(%rax), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rdx
               	movl	$0xf, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	andq	$0x1, %rax
               	leaq	0xa(%rax), %rsi
               	movq	(%rcx), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	cmpl	$0xb0, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
