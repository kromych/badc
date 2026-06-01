
unsigned_compound_assign.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0x64, %r11d
               	movl	%r11d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movl	(%r9), %r11d
               	addq	$0x5, %r11
               	movl	%r11d, (%r9)
               	movl	-0x8(%rbp), %r9d
               	xorq	$0x69, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x8(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rsi
               	movl	(%rsi), %eax
               	subq	$0x3, %rax
               	movl	%eax, (%rsi)
               	movl	-0x8(%rbp), %esi
               	xorq	$0x66, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x8(%rbp), %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	movq	%rsi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	addq	$0x19f, %rsi            # imm = 0x19F
               	movq	%rsi, (%rax)
               	movq	-0x10(%rbp), %rdi
               	cmpq	$0x587, %rdi            # imm = 0x587
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	-0x10(%rbp), %rdi
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x41c, %edi            # imm = 0x41C
               	movl	%edi, -0x18(%rbp)
               	movl	$0x19f, %eax            # imm = 0x19F
               	leaq	-0x18(%rbp), %rdi
               	movl	(%rdi), %esi
               	addq	%rax, %rsi
               	movl	%esi, (%rdi)
               	movl	-0x18(%rbp), %edi
               	xorq	$0x5bb, %rdi            # imm = 0x5BB
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	-0x18(%rbp), %esi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc8, %esi
               	movb	%sil, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rdi
               	movzbq	(%rdi), %rsi
               	addq	$0x3c, %rsi
               	movb	%sil, (%rdi)
               	movzbq	-0x28(%rbp), %rdi
               	xorq	$0x4, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %rax
               	movzbq	-0x28(%rbp), %rsi
               	movq	%rax, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rsi
               	xorq	%rdi, %rdi
               	movl	%edi, (%rsi)
               	leaq	-0x40(%rbp), %rax
               	addq	$0x4, %rax
               	movl	$0xa, %edi
               	movl	%edi, (%rax)
               	leaq	-0x40(%rbp), %rsi
               	addq	$0x8, %rsi
               	movl	$0x14, %edi
               	movl	%edi, (%rsi)
               	leaq	-0x40(%rbp), %rax
               	addq	$0xc, %rax
               	movl	$0x1e, %edi
               	movl	%edi, (%rax)
               	leaq	-0x40(%rbp), %rsi
               	addq	$0x10, %rsi
               	movl	$0x28, %edi
               	movl	%edi, (%rsi)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rdi
               	movq	(%rdi), %rax
               	addq	$0xc, %rax
               	movq	%rax, (%rdi)
               	movq	-0x48(%rbp), %rsi
               	movslq	(%rsi), %rsi
               	cmpq	$0x1e, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	-0x48(%rbp), %rsi
               	movslq	(%rsi), %rax
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movl	$0x1, %esi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
