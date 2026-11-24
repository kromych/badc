
inline_one_word_struct.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	movq	$0x64, 0x8(%rsp)
               	movq	$0xc8, 0x10(%rsp)
               	movq	$0x12c, 0x18(%rsp)      # imm = 0x12C
               	movq	$0x190, 0x20(%rsp)      # imm = 0x190
               	movq	$0x1f4, 0x28(%rsp)      # imm = 0x1F4
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	0x8(%rsp,%rax,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	cmpq	$0x5dc, %rcx            # imm = 0x5DC
               	cmovneq	%rdx, %rax
               	addq	$0x38, %rsp
               	retq
