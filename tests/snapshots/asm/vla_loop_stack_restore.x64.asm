
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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %eax
               	movl	%eax, -0x10(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, %r9
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rsp, %r12
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
               	movq	%rax, %rdx
               	movb	%dl, (%rcx)
               	leaq	-0x1(%rdi), %rdx
               	leaq	0x1(%rax), %r8
               	movq	%r8, %rbx
               	movb	%bl, (%rcx,%rdx)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rsi
               	movsbq	(%rcx), %r8
               	movsbq	(%rcx,%rdx), %rcx
               	addq	%r8, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %r9
               	movq	%r12, %rsp
               	jmp	<addr>
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpq	$0x1000, %r9            # imm = 0x1000
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	leaq	-0x20(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	leaq	-0x20(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
