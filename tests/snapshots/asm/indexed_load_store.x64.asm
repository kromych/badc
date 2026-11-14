
indexed_load_store.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	pushq	%rbx
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
               	leaq	-0x40(%rbp), %r8
               	leaq	-0x20(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	leaq	(%r8,%rdi), %rdx
               	movl	(%rdx), %r9d
               	addq	$0x3, %r9
               	addq	%rsi, %rdi
               	movl	(%rdi), %ebx
               	subq	$0x3, %rbx
               	movl	%ebx, (%rdx)
               	movl	%r9d, -0x20(%rbp,%rax,4)
               	movl	(%rdx), %edx
               	movl	(%rdi), %edi
               	imulq	%rdi, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	cmpl	$0xb7c, %ecx            # imm = 0xB7C
               	cmovneq	%rdx, %rax
               	popq	%rbx
               	leave
               	retq
