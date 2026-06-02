
u16_load_store.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	-0x10(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movzbq	0x8(%r9), %rax
               	movb	%al, 0x8(%r11)
               	movzbq	0x9(%r9), %rax
               	movb	%al, 0x9(%r11)
               	popq	%rax
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0xa, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x20(%rbp), %rax
               	addq	$0x2, %rax
               	movl	$0x4241, %esi           # imm = 0x4241
               	movw	%si, (%rax)
               	leaq	-0x20(%rbp), %rdi
               	movzbq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x40(%rbp)
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rsi
               	addq	$0x1, %rsi
               	movzbq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x40(%rbp)
               	jmp	<addr>
               	movq	-0x40(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rsi
               	addq	$0x2, %rsi
               	movzbq	(%rsi), %rsi
               	xorq	$0x41, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x3, %rdi
               	movzbq	(%rdi), %rdi
               	xorq	$0x42, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x2, %esi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	addq	$0x4, %rdi
               	movzbq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdi
               	addq	$0x1, %rdi
               	movzwq	(%rdi), %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	xorq	$0x4342, %rdi           # imm = 0x4342
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
