
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
               	jmp	<addr>
               	leaq	-0xa8(%rbp), %rdx
               	movslq	%eax, %rcx
               	movl	$0xdeadbeef, %esi       # imm = 0xDEADBEEF
               	movl	%esi, (%rdx,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rsi
               	movl	(%rsi), %eax
               	movl	0x9c(%rsi), %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leaq	-0x70(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	movups	%xmm14, 0x30(%rdi)
               	movups	%xmm14, 0x40(%rdi)
               	movups	%xmm14, 0x50(%rdi)
               	movl	$0x0, 0x60(%rdi)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	%ecx, %ecx
               	movslq	%eax, %rdx
               	movl	(%rdi,%rdx,4), %r8d
               	addq	%r8, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x19, %eax
               	jl	<addr>
               	movl	%ecx, %r8d
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movl	$0x12345678, %edx       # imm = 0x12345678
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x9c(%rax), %eax
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
               	jmp	<addr>
               	movl	%ecx, %ecx
               	movslq	%eax, %rdx
               	movl	(%rsi,%rdx,4), %edi
               	addq	%rdi, %rcx
               	leaq	0x1(%rdx), %rax
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
