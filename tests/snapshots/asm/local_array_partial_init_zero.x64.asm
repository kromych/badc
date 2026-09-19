
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
               	xorl	%eax, %eax
               	cmpl	$0x28, %eax
               	jge	<addr>
               	leaq	-0xa8(%rbp), %rcx
               	movl	$0xdeadbeef, %edx       # imm = 0xDEADBEEF
               	movl	%edx, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	movl	(%rdx), %eax
               	movl	0x9c(%rdx), %ecx
               	addq	%rcx, %rax
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
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x19, %eax
               	jge	<addr>
               	movl	(%rsi,%rax,4), %edi
               	addq	%rdi, %rcx
               	incq	%rax
               	cmpl	$0x19, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x28, %eax
               	jge	<addr>
               	movl	$0x12345678, %esi       # imm = 0x12345678
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movl	(%rax), %edx
               	movl	0x9c(%rax), %eax
               	addq	%rdx, %rax
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
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	$0x19, %eax
               	jge	<addr>
               	movl	(%rsi,%rax,4), %edi
               	addq	%rdi, %rdx
               	incq	%rax
               	cmpl	$0x19, %eax
               	jl	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
