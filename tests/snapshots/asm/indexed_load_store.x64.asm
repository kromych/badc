
indexed_load_store.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movabsq	$0x200000001, %rax      # imm = 0x200000001
               	movabsq	$0x140000000a, %rcx     # imm = 0x140000000A
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movabsq	$0x400000003, %rax      # imm = 0x400000003
               	movabsq	$0x280000001e, %rcx     # imm = 0x280000001E
               	movq	%rax, -0x38(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movabsq	$0x600000005, %rax      # imm = 0x600000005
               	movabsq	$0x3c00000032, %rcx     # imm = 0x3C00000032
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movabsq	$0x800000007, %rax      # imm = 0x800000007
               	movabsq	$0x5000000046, %rcx     # imm = 0x5000000046
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	-0x40(%rbp,%rax,4), %edi
               	addq	$0x3, %rdi
               	movl	-0x20(%rbp,%rax,4), %r8d
               	subq	$0x3, %r8
               	movl	%r8d, -0x40(%rbp,%rax,4)
               	movl	%edi, -0x20(%rbp,%rax,4)
               	movl	-0x40(%rbp,%rax,4), %r8d
               	imulq	%r8, %rdi
               	addq	%rdi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	cmpl	$0xb7c, %ecx            # imm = 0xB7C
               	cmovneq	%rdx, %rax
               	leave
               	retq
