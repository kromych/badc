
vla_loop_stack_restore.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movq	%rax, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movsbq	(%rcx), %r8
               	movsbq	(%rcx,%rdx), %rcx
               	addq	%r8, %rcx
               	addq	%rcx, %rdi
               	movq	%r9, %rsp
               	incq	%rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movslq	-0x10(%rbp), %rdx
               	shlq	$0x12, %rdx
               	movq	%rsp, %r9
               	movq	%rdx, %r11
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
               	decq	%rdx
               	leaq	0x1(%rax), %r8
               	movb	%r8b, (%rcx,%rdx)
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	movl	$0x2, %ecx
               	cmpq	$0x1000, %rdi           # imm = 0x1000
               	cmovneq	%rcx, %rax
               	leave
               	retq
