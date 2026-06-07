
local_array_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	leaq	<rip>, %rax
               	movzwq	(%rax,%rdi,2), %rax
               	leaq	-0x8(%rbp), %rcx
               	movw	%ax, (%rcx)
               	leaq	<rip>, %rax
               	movzwq	(%rax,%rdi,2), %rax
               	leaq	-0x8(%rbp), %rcx
               	addq	$0x2, %rcx
               	movw	%ax, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movslq	%eax, %rdx
               	leaq	-0x8(%rbp), %rcx
               	addq	$0x2, %rcx
               	movzwq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	%eax, (%rcx)
               	imulq	%rsi, %rdi
               	movslq	%edi, %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x8, %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	movq	%rdi, %rax
               	addq	%rsi, %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, (%rcx)
               	subq	%rsi, %rdi
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movq	%rdi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	movq	%rdi, %rax
               	addq	$0x61, %rax
               	movslq	%eax, %rax
               	andq	$0xff, %rax
               	leaq	-0x8(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0x62, %eax
               	leaq	-0x8(%rbp), %rcx
               	addq	$0x1, %rcx
               	movb	%al, (%rcx)
               	addq	$0x1, %rdi
               	movslq	%edi, %rax
               	andq	$0xff, %rax
               	leaq	-0x8(%rbp), %rcx
               	addq	$0x2, %rcx
               	movb	%al, (%rcx)
               	movl	$0x64, %eax
               	leaq	-0x8(%rbp), %rcx
               	addq	$0x3, %rcx
               	movb	%al, (%rcx)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	cmpq	$0x4, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	movslq	%eax, %rax
               	leaq	-0x8(%rbp), %rsi
               	movslq	%ecx, %rdx
               	addq	%rdx, %rsi
               	movzbq	(%rsi), %rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	<rip>, %rcx
               	addq	$0xa, %rcx
               	movl	$0x1234, %eax           # imm = 0x1234
               	movw	%ax, (%rcx)
               	leaq	<rip>, %rax
               	addq	$0xa, %rax
               	movl	$0x5678, %ecx           # imm = 0x5678
               	movw	%cx, (%rax)
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x477198, %rax         # imm = 0x477198
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x4, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x6f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x5, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
