
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
               	subq	$0x60, %rsp
               	leaq	-0x30(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rsi
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rdi
               	movq	%rdi, (%rsi,%rcx,8)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rax
               	leaq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	addq	$0x0, %rcx
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x55, %rax
               	cmpq	$0xa055, %rax           # imm = 0xA055
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
