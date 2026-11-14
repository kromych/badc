
inline_struct_return_reg.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	xorl	%eax, %eax
               	movq	-0x20(%rbp,%rax,8), %rsi
               	movq	%rsi, -0x40(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	$0x55, %rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0xa055, %rax           # imm = 0xA055
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	leave
               	retq
