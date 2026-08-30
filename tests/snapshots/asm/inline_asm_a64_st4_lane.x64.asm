
inline_asm_a64_st4_lane.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x38(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rsi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x58(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movq	%rax, 0x10(%rdx)
               	movq	%rax, 0x18(%rdx)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rsi), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%rsi), %rax
               	movq	%rax, 0x18(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movl	(%rdx,%rcx,4), %edi
               	movl	(%rsi,%rcx,4), %r8d
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x28(%rbp), %rsi
               	xorq	%rax, %rax
               	movq	%rax, (%rsi)
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movzwq	(%rsi,%rcx,2), %rdi
               	movzwq	(%rdx,%rcx,2), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x48(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, (%rdx)
               	movq	%rax, 0x8(%rdx)
               	movq	%rax, 0x10(%rdx)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rsi), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rdi
               	movq	(%rsi,%rcx,8), %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x9, %edx
               	movl	%edx, (%rax)
               	movl	$0xd, %edx
               	movl	%edx, 0x4(%rax)
               	movl	(%rax), %edx
               	cmpl	$0x9, %edx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0xd, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
