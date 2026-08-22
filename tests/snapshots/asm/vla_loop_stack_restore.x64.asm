
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0x1, %eax
               	movl	%eax, -0x10(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, %r8
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rsp, %r12
               	movslq	-0x10(%rbp), %rcx
               	movq	%rcx, %rsi
               	shlq	$0x12, %rsi
               	movq	%rsi, %r11
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
               	movslq	%eax, %rdi
               	movb	%dil, (%rcx)
               	leaq	-0x1(%rsi), %r9
               	leaq	(%rcx,%r9), %r13
               	leaq	0x1(%rax), %rdi
               	movslq	%edi, %rbx
               	movb	%bl, (%r13)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rdx
               	movsbq	(%rcx), %rdi
               	addq	%r9, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %r8
               	movq	%r12, %rsp
               	jmp	<addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	$0x1000, %r8            # imm = 0x1000
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
