
switch_jump_table_phi_join.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<chain>:
               	movslq	%edi, %rdi
               	cmpq	$0xc, %rdi
               	jae	<addr>
               	jmp	<addr>
               	imulq	$0x1f, %rsi, %rax
               	addq	%rdx, %rax
               	retq
               	incq	%rsi
               	leaq	0x2(%rsi), %rdx
               	addq	%rdx, %rsi
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rsi
               	addq	%rsi, %rdx
               	shlq	$0x1, %rsi
               	decq	%rdx
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rdx
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %edx
               	jmp	<addr>
               	leaq	<rip>, %r11         # <addr>
               	movslq	(%r11,%rdi,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	stosb	%al, %es:(%rdi)
               	<unknown>
               	pushq	<rip>
               	addb	%al, (%rax)
               	addb	%bh, (%rdi)
               	addb	%al, (%rax)
               	addb	%al, (%rax,%rax)
               	addb	%cl, (%rcx)
               	addb	%al, (%rax)
               	addb	%r8b, (%rax)
               	addb	%dl, (%rbx)
               	addb	%al, (%rax)
               	popq	%rax
               	addb	%al, (%rax)
               	addb	%bl, (%rbp)
               	addb	%al, (%rax)
               	sarl	%edi
               	<unknown>
               	<unknown>
               	<unknown>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	xorq	%rcx, %rcx
               	movabsq	$-0x2, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0xe, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	jmp	<addr>
               	movabsq	$-0x1, %r12
               	jmp	<addr>
               	movabsq	$-0x2eb506b7b9cbd8a0, %r11 # imm = 0xD14AF94846342760
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %r12
               	jge	<addr>
               	jmp	<addr>
               	incq	%r12
               	jmp	<addr>
               	xorq	%r13, %r13
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x3, %r13
               	jge	<addr>
               	jmp	<addr>
               	incq	%r13
               	jmp	<addr>
               	imulq	$0x21, %rcx, %r14
               	movslq	%ebx, %rdi
               	movq	%r12, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	leaq	(%r14,%rax), %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
