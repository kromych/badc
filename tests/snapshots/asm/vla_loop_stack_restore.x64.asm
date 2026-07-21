
vla_loop_stack_restore.x64:	file format elf64-x86-64

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
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, %r9
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rsp, %r12
               	movslq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdi
               	shlq	$0x12, %rdi
               	movq	%rdi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	movq	%rcx, %rsp
               	movslq	%eax, %r8
               	movb	%r8b, (%rcx)
               	leaq	-0x1(%rdi), %r8
               	leaq	(%rcx,%r8), %r13
               	leaq	0x1(%rax), %r8
               	movslq	%r8d, %rbx
               	movb	%bl, (%r13)
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	%rcx, %rdx
               	movsbq	(%rcx), %r8
               	decq	%rdi
               	addq	%rdi, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%r8, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %r9
               	movq	%r12, %rsp
               	jmp	<addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	0x1(%rsi), %rax
               	movslq	%eax, %rsi
               	cmpq	$0x40, %rsi
               	jl	<addr>
               	cmpq	$0x1000, %r9            # imm = 0x1000
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	leaq	-0x70(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
