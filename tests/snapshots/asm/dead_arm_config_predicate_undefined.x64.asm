
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
               	movslq	%eax, %rax
               	movq	(%rdi), %rcx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%rdx, %rdx
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rax), %rsi
               	andq	$0x8, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	leaq	(%rcx), %rsi
               	movl	$0x1, %edx
               	movq	%rdx, (%rax)
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
               	leaq	(%rcx,%rdx), %rax
               	movslq	%eax, %rax
               	addq	%rax, %rsi
               	movl	$0x2, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rax), %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
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
               	movslq	%ecx, %rcx
               	movq	(%rax), %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
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
               	movslq	%ecx, %rcx
               	movq	(%rax), %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
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
               	movslq	%ecx, %rcx
               	movq	(%rax), %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
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
               	movslq	%ecx, %rcx
               	movq	(%rax), %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
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
               	movslq	%ecx, %rcx
               	movq	(%rax), %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
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
               	movslq	%ecx, %rcx
               	movq	(%rax), %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
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
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rdx)
               	leaq	-0x8(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movq	(%rdx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rdx), %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	(%rsi), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rsi), %rcx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	jmp	<addr>
