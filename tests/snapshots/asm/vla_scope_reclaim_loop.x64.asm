
vla_scope_reclaim_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rdi, %rdi
               	movq	%rdi, %r9
               	jmp	<addr>
               	movq	%rsp, %rbx
               	movl	$0x100, %eax            # imm = 0x100
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	movq	%rdx, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%eax, (%rdx,%rcx,4)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
               	jl	<addr>
               	movq	%r8, %rax
               	andq	$0x3f, %rax
               	movslq	(%rdx,%rax,4), %rax
               	addq	%rax, %r9
               	movq	%rbx, %rsp
               	leaq	0x1(%r8), %rdi
               	movslq	%edi, %r8
               	cmpq	$0x186a0, %r8           # imm = 0x186A0
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rcx, %rsi
               	andq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x186a0, %rcx          # imm = 0x186A0
               	jl	<addr>
               	cmpq	%rdx, %r9
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
