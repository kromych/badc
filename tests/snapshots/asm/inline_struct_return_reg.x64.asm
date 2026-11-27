
inline_struct_return_reg.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	leaq	0x20(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%eax, %eax
               	movq	0x20(%rsp,%rax,8), %rsi
               	movq	%rsi, (%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x55, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0xa055, %rax           # imm = 0xA055
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	addq	$0x48, %rsp
               	retq
