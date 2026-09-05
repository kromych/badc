
vla_scope_reclaim_loop.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	xorq	%rdi, %rdi
               	movq	%rdi, %r8
               	jmp	<addr>
               	movq	%rsp, %r9
               	movl	$0x100, %eax            # imm = 0x100
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movl	%eax, (%rdx,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movslq	%edi, %rax
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	movslq	(%rdx,%rcx,4), %rcx
               	addq	%rcx, %r8
               	movq	%r9, %rsp
               	leaq	0x1(%rax), %rdi
               	cmpl	$0x186a0, %edi          # imm = 0x186A0
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	andq	$0x3f, %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	cmpq	%rcx, %r8
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
