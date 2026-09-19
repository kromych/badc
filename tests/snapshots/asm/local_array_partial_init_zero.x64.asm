
local_array_partial_init_zero.x64:	file format elf64-x86-64

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
               	subq	$0xb0, %rsp
               	xorq	%rax, %rax
               	cmpl	$0x28, %eax
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rcx
               	movslq	%eax, %rdx
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	%esi, (%rcx,%rdx,4)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	movl	(%rdx), %eax
               	movl	0x9c(%rdx), %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leaq	-0x70(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movups	%xmm14, 0x10(%rsi)
               	movups	%xmm14, 0x20(%rsi)
               	movups	%xmm14, 0x30(%rsi)
               	movups	%xmm14, 0x40(%rsi)
               	movups	%xmm14, 0x50(%rsi)
               	movl	$0x0, 0x60(%rsi)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x19, %eax
               	jge	<addr>
               	movl	%ecx, %edi
               	movslq	%eax, %rcx
               	movl	(%rsi,%rcx,4), %ecx
               	addq	%rdi, %rcx
               	incq	%rax
               	cmpl	$0x19, %eax
               	jl	<addr>
               	movl	%ecx, %r8d
               	xorq	%rax, %rax
               	cmpl	$0x28, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	movl	$0x12345678, %esi       # imm = 0x12345678
               	movl	%esi, (%rdx,%rcx,4)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x9c(%rax), %eax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leaq	-0x70(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movups	%xmm14, 0x10(%rdx)
               	movups	%xmm14, 0x20(%rdx)
               	movups	%xmm14, 0x30(%rdx)
               	movups	%xmm14, 0x40(%rdx)
               	movups	%xmm14, 0x50(%rdx)
               	movl	$0x0, 0x60(%rdx)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x19, %eax
               	jge	<addr>
               	movl	%ecx, %esi
               	movslq	%eax, %rcx
               	movl	(%rdx,%rcx,4), %ecx
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x19, %eax
               	jl	<addr>
               	movl	%ecx, %eax
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
