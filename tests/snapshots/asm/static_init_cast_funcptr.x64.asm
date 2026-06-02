
static_init_cast_funcptr.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
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
               	movslq	%edi, %r11
               	shlq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	movabsq	$-0x1, %rax
               	imulq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %r11
               	addq	$0x8, %r11
               	movq	(%r11), %r11
               	movl	$0x15, %edi
               	callq	*%r11
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	movl	$0x7, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, %r11
               	cmpq	$-0x7, %r11
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x10, %r11
               	movq	(%r11), %r11
               	leaq	<rip>, %rdi
               	callq	*%r11
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdi
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, %r11
               	cmpq	$-0x11, %r11
               	je	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movq	(%r11), %r11
               	movzbq	(%r11), %r11
               	xorq	$0x64, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	addq	$0x18, %r11
               	movq	(%r11), %r11
               	movzbq	(%r11), %r11
               	xorq	$0x6e, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	leaq	<rip>, %r11
               	movq	%r11, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	addb	%al, (%rax)
