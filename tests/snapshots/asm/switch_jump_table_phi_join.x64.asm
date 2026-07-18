
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
               	popq	%rdi
               	addb	%al, (%rax)
               	addb	%ah, (%rcx)
               	addb	%al, (%rax)
               	movslq	(%rax), %eax
               	addb	%al, (%rax)
               	addb	%al, %gs:(%rax)
               	addb	%ah, (%rdi)
               	addb	%al, (%rax)
               	imull	$0x6b0000, (%rax), %eax # imm = 0x6B0000
               	addb	%al, (%rax)
               	insl	%dx, %es:(%rdi)
               	addb	%al, (%rax)
               	addb	%ch, (%rdi)
               	addb	%al, (%rax)
               	jno	<addr>
               	addb	%al, (%rax)
               	jp	<addr>
               	addb	%al, (%rax)
               	incq	%rsi
               	leaq	0x2(%rsi), %rdx
               	addq	%rdx, %rsi
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rsi
               	addq	%rsi, %rdx
               	shlq	%rsi
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rax, %rax
               	movabsq	$-0x2, %r12
               	jmp	<addr>
               	movabsq	$-0x1, %rbx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	imulq	$0x21, %rax, %r13
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x1, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x2, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	incq	%rbx
               	cmpq	$0x3, %rbx
               	jl	<addr>
               	movslq	%r12d, %rcx
               	leaq	0x1(%rcx), %r12
               	movslq	%r12d, %rcx
               	cmpq	$0xe, %rcx
               	jl	<addr>
               	movabsq	$-0x2eb506b7b9cbd8a0, %r11 # imm = 0xD14AF94846342760
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
