
inline_one_word_struct.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rcx
               	leaq	(%rcx), %rax
               	movl	$0x64, %edx
               	movq	%rdx, (%rax)
               	movl	$0xc8, %eax
               	movq	%rax, 0x8(%rcx)
               	movl	$0x12c, %eax            # imm = 0x12C
               	movq	%rax, 0x10(%rcx)
               	movl	$0x190, %eax            # imm = 0x190
               	movq	%rax, 0x18(%rcx)
               	movl	$0x1f4, %eax            # imm = 0x1F4
               	movq	%rax, 0x20(%rcx)
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	(%rcx,%rsi,8), %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpq	$0x5dc, %rdx            # imm = 0x5DC
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
