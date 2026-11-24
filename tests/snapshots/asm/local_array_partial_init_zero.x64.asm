
local_array_partial_init_zero.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0xb8, %rsp
               	xorl	%eax, %eax
               	movl	$0xdeadbeef, (%rsp,%rax,4) # imm = 0xDEADBEEF
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	movl	(%rsp), %eax
               	movl	0x9c(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	%eax, 0xa0(%rsp)
               	movl	0xa0(%rsp), %eax
               	leaq	0x38(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movups	%xmm14, 0x10(%rdx)
               	movups	%xmm14, 0x20(%rdx)
               	movups	%xmm14, 0x30(%rdx)
               	movups	%xmm14, 0x40(%rdx)
               	movups	%xmm14, 0x50(%rdx)
               	movl	$0x0, 0x60(%rdx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	0x38(%rsp,%rax,4), %edi
               	addq	%rdi, %rcx
               	incq	%rax
               	cmpl	$0x19, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	$0x12345678, (%rsp,%rax,4) # imm = 0x12345678
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	movl	(%rsp), %eax
               	movl	0x9c(%rsp), %edx
               	addq	%rdx, %rax
               	movl	%eax, 0xa8(%rsp)
               	movl	0xa8(%rsp), %eax
               	leaq	0x38(%rsp), %rsi
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
               	movl	0x38(%rsp,%rax,4), %edi
               	addq	%rdi, %rdx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x19, %eax
               	jl	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb8, %rsp
               	retq
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xb8, %rsp
               	retq
