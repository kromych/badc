
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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x1, -0x10(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %r9
               	movq	%rax, %rdi
               	movq	%rsp, %rbx
               	movslq	-0x10(%rbp), %rcx
               	movq	%rcx, %r8
               	shlq	$0x12, %r8
               	movq	%r8, %r11
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
               	leaq	-0x1(%r8), %rsi
               	leaq	0x1(%rax), %rdx
               	movb	%dl, (%rcx,%rsi)
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rdi
               	jmp	<addr>
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movsbq	(%rcx), %rdx
               	movsbq	(%rcx,%rsi), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %r9
               	movq	%rbx, %rsp
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	$0x1000, %r9            # imm = 0x1000
               	jne	<addr>
               	movl	$0x2a, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
