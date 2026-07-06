
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
               	leaq	<rip>, %r11         # <addr>
               	movslq	(%r11,%rdi,4), %r10
               	addq	%r11, %r10
               	jmpq	*%r10
               	xorb	%al, (%rax)
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	addb	%ah, (%rdx)
               	addb	%al, (%rax)
               	addb	%al, %fs:(%rax)
               	addb	%ah, (%rsi)
               	addb	%al, (%rax)
               	pushq	$0x6a000000             # imm = 0x6A000000
               	addb	%al, (%rax)
               	addb	%ch, (%rax,%rax)
               	addb	%ch, (%rsi)
               	addb	%al, (%rax)
               	jo	<addr>
               	addb	%al, (%rax)
               	jb	<addr>
               	addb	%al, (%rax)
               	jnp	<addr>
               	addb	%al, (%rax)
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
               	imulq	$0x1f, %rsi, %rax
               	addq	%rdx, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rdx
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %edx
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rcx, %rcx
               	movabsq	$-0x2, %rbx
               	jmp	<addr>
               	movabsq	$-0x1, %r12
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	imulq	$0x21, %rcx, %r13
               	movslq	%ebx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x1, %edx
               	imulq	$0x21, %rax, %r13
               	movslq	%ebx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x2, %edx
               	imulq	$0x21, %rax, %r13
               	movslq	%ebx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	(%r13,%rax), %rcx
               	incq	%r12
               	cmpq	$0x3, %r12
               	jl	<addr>
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0xe, %rax
               	jl	<addr>
               	movabsq	$-0x2eb506b7b9cbd8a0, %r11 # imm = 0xD14AF94846342760
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
