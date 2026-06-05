
local_array_partial_init_zero.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rdi, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, -0xa8(%rbp)
               	jmp	<addr>
               	movslq	-0xa8(%rbp), %rcx
               	cmpq	$0x28, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0xa8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	addq	$0x1, %rdx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %rcx
               	movslq	-0xa8(%rbp), %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	movl	%eax, %edx
               	movl	%edx, (%rcx)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	movq	0x30(%rcx), %r11
               	movq	%r11, 0x30(%rax)
               	movq	0x38(%rcx), %r11
               	movq	%r11, 0x38(%rax)
               	movq	0x40(%rcx), %r11
               	movq	%r11, 0x40(%rax)
               	movq	0x48(%rcx), %r11
               	movq	%r11, 0x48(%rax)
               	movq	0x50(%rcx), %r11
               	movq	%r11, 0x50(%rax)
               	movq	0x58(%rcx), %r11
               	movq	%r11, 0x58(%rax)
               	movzbq	0x60(%rcx), %r11
               	movb	%r11b, 0x60(%rax)
               	movzbq	0x61(%rcx), %r11
               	movb	%r11b, 0x61(%rax)
               	movzbq	0x62(%rcx), %r11
               	movb	%r11b, 0x62(%rax)
               	movzbq	0x63(%rcx), %r11
               	movb	%r11b, 0x63(%rax)
               	popq	%r11
               	xorq	%rax, %rax
               	movl	%eax, -0x70(%rbp)
               	movl	%eax, -0x78(%rbp)
               	jmp	<addr>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x19, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	movl	(%rax), %ecx
               	leaq	-0x68(%rbp), %rdx
               	movslq	-0x78(%rbp), %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movl	(%rdx), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	movl	-0x70(%rbp), %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xdeadbeef, %edi       # imm = 0xDEADBEEF
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x12345678, %edi       # imm = 0x12345678
               	callq	<addr>
               	callq	<addr>
               	movl	%ebx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
