
vla_loop_stack_restore.x64:	file format elf64-x86-64

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
               	movl	$0x1, -0x10(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	movq	%rax, %rdx
               	movq	%rsp, %r8
               	movslq	-0x10(%rbp), %rcx
               	movq	%rcx, %rdi
               	shlq	$0x12, %rdi
               	movq	%rdi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movb	%al, (%rcx)
               	decq	%rdi
               	leaq	0x1(%rax), %r9
               	movb	%r9b, (%rcx,%rdi)
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movsbq	(%rcx), %r9
               	movsbq	(%rcx,%rdi), %rcx
               	addq	%r9, %rcx
               	addq	%rcx, %rsi
               	movq	%r8, %rsp
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	$0x1000, %rsi           # imm = 0x1000
               	jne	<addr>
               	movl	$0x2a, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
