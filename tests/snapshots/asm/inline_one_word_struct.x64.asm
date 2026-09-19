
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
               	leaq	-0x28(%rbp), %rdx
               	movq	$0x64, (%rdx)
               	movq	$0xc8, 0x8(%rdx)
               	movq	$0x12c, 0x10(%rdx)      # imm = 0x12C
               	movq	$0x190, 0x18(%rdx)      # imm = 0x190
               	movq	$0x1f4, 0x20(%rdx)      # imm = 0x1F4
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	(%rdx,%rax,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpq	$0x5dc, %rcx            # imm = 0x5DC
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
