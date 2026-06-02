
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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	leaq	-0x8(%rbp), %r9
               	leaq	<rip>, %r8
               	pushq	%rax
               	movzbq	(%r8), %rax
               	movb	%al, (%r9)
               	movzbq	0x1(%r8), %rax
               	movb	%al, 0x1(%r9)
               	movzbq	0x2(%r8), %rax
               	movb	%al, 0x2(%r9)
               	movzbq	0x3(%r8), %rax
               	movb	%al, 0x3(%r9)
               	popq	%rax
               	leaq	<rip>, %r9
               	movq	%r11, %r8
               	shlq	$0x1, %r8
               	addq	%r8, %r9
               	movzwq	(%r9), %r9
               	leaq	-0x8(%rbp), %r8
               	movw	%r9w, (%r8)
               	leaq	<rip>, %rdi
               	shlq	$0x1, %r11
               	addq	%r11, %rdi
               	movzwq	(%rdi), %rdi
               	leaq	-0x8(%rbp), %r11
               	addq	$0x2, %r11
               	movw	%di, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r8
               	movl	$0x3e8, %r11d           # imm = 0x3E8
               	imulq	%r11, %r8
               	movslq	%r8d, %r8
               	leaq	-0x8(%rbp), %r11
               	addq	$0x2, %r11
               	movzwq	(%r11), %r11
               	addq	%r11, %r8
               	movslq	%r8d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	leaq	-0x10(%rbp), %r8
               	leaq	<rip>, %rdi
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	movzbq	0x8(%rdi), %rax
               	movb	%al, 0x8(%r8)
               	movzbq	0x9(%rdi), %rax
               	movb	%al, 0x9(%r8)
               	movzbq	0xa(%rdi), %rax
               	movb	%al, 0xa(%r8)
               	movzbq	0xb(%rdi), %rax
               	movb	%al, 0xb(%r8)
               	popq	%rax
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	leaq	-0x10(%rbp), %rdi
               	movl	%r8d, (%rdi)
               	movq	%r11, %rsi
               	subq	%r9, %rsi
               	movslq	%esi, %rsi
               	leaq	-0x10(%rbp), %rdi
               	addq	$0x4, %rdi
               	movl	%esi, (%rdi)
               	imulq	%r9, %r11
               	movslq	%r11d, %r11
               	leaq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movl	%r11d, (%r9)
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r8
               	leaq	-0x10(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	leaq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	leaq	-0x10(%rbp), %r8
               	leaq	<rip>, %rdi
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%r8)
               	popq	%rax
               	movq	%r11, %r8
               	addq	%r9, %r8
               	leaq	-0x10(%rbp), %rdi
               	movq	%r8, (%rdi)
               	subq	%r9, %r11
               	leaq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movq	%r11, (%r9)
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rsi
               	leaq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r9
               	addq	%r9, %rsi
               	movslq	%esi, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %r11
               	leaq	-0x8(%rbp), %r9
               	leaq	<rip>, %r8
               	pushq	%rax
               	movzbq	(%r8), %rax
               	movb	%al, (%r9)
               	movzbq	0x1(%r8), %rax
               	movb	%al, 0x1(%r9)
               	movzbq	0x2(%r8), %rax
               	movb	%al, 0x2(%r9)
               	movzbq	0x3(%r8), %rax
               	movb	%al, 0x3(%r9)
               	popq	%rax
               	movq	%r11, %r9
               	addq	$0x61, %r9
               	movslq	%r9d, %r9
               	andq	$0xff, %r9
               	leaq	-0x8(%rbp), %r8
               	movb	%r9b, (%r8)
               	movl	$0x62, %edi
               	leaq	-0x8(%rbp), %r8
               	addq	$0x1, %r8
               	movb	%dil, (%r8)
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	andq	$0xff, %r11
               	leaq	-0x8(%rbp), %r9
               	addq	$0x2, %r9
               	movb	%r11b, (%r9)
               	movl	$0x64, %r8d
               	leaq	-0x8(%rbp), %r9
               	addq	$0x3, %r9
               	movb	%r8b, (%r9)
               	xorq	%r11, %r11
               	movl	%r11d, -0x10(%rbp)
               	movl	%r11d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r11
               	cmpq	$0x4, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r8
               	leaq	-0x8(%rbp), %r9
               	movslq	-0x18(%rbp), %rdi
               	addq	%rdi, %r9
               	movzbq	(%r9), %r9
               	addq	%r9, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	<rip>, %r11
               	addq	$0xa, %r11
               	movl	$0x1234, %r9d           # imm = 0x1234
               	movw	%r9w, (%r11)
               	leaq	<rip>, %r8
               	addq	$0xa, %r8
               	movl	$0x5678, %r9d           # imm = 0x5678
               	movw	%r9w, (%r8)
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x477198, %rax         # imm = 0x477198
               	je	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movl	$0x4, %esi
               	movq	%rax, %rdi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%r11
               	movq	(%rsi), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rsi), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rsi), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rsi), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rsi), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rbp), %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsi
               	addq	$0x8, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%r11
               	movq	(%rsi), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x28(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x4, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x6f, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x28(%rbp)
               	jmp	<addr>
               	movq	-0x28(%rbp), %rsi
               	movq	%rsi, -0x20(%rbp)
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	addq	$0x5, %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %esi
               	movq	%rsi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
