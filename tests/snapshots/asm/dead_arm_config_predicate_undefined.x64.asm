
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
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rcx
               	movq	(%rdi), %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rcx, %rcx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movl	$0xa, %edx
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	movslq	%edx, %rdx
               	movq	(%rax), %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	(%rdx,%rcx), %rax
               	movslq	%eax, %rax
               	leaq	0xa(%rax), %rsi
               	movl	$0x2, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rdx
               	movq	(%rax), %rcx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movl	$0x3, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rax), %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	(%rdx,%rax), %rsi
               	movl	$0x4, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rdx
               	movq	(%rax), %rcx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rax), %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	(%rdx,%rax), %rsi
               	movl	$0x6, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rdx
               	movq	(%rax), %rcx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movl	$0x7, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rax), %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	(%rdx,%rax), %rsi
               	movl	$0x8, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rdx
               	movq	(%rax), %rcx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movl	$0x9, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rax), %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	(%rdx,%rax), %rsi
               	movl	$0xa, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rdx
               	movq	(%rax), %rcx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movl	$0xb, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rax), %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	(%rdx,%rax), %rsi
               	movl	$0xc, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rdx
               	movq	(%rax), %rcx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rax), %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	(%rdx,%rax), %rsi
               	movl	$0xe, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rdx
               	movq	(%rax), %rcx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rsi,%rcx), %rdx
               	movl	$0xf, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rax), %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movl	$0xa, %eax
               	movl	$0xb, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
