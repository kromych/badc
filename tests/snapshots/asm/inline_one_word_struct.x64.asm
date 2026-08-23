
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
               	leaq	(%rdx), %rax
               	movl	$0x64, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xc8, %eax
               	movq	%rax, 0x8(%rdx)
               	movl	$0x12c, %eax            # imm = 0x12C
               	movq	%rax, 0x10(%rdx)
               	movl	$0x190, %eax            # imm = 0x190
               	movq	%rax, 0x18(%rdx)
               	movl	$0x1f4, %eax            # imm = 0x1F4
               	movq	%rax, 0x20(%rdx)
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rdi
               	addq	%rdi, %rsi
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	cmpq	$0x5dc, %rsi            # imm = 0x5DC
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
