
pointer_to_array_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40048d <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfda9(%rip)           # 0x410100
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd96(%rip), %r9       # 0x410110
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x4003cb <.text+0x8b>
               	leaq	0xfd72(%rip), %rdi      # 0x410110
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfd4f(%rip), %rdi      # 0x410128
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd3d(%rip), %rsi      # 0x41012e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd2c(%rip), %r9       # 0x410135
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4008b7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400459 <.text+0x119>
               	leaq	0xfccf(%rip), %r14      # 0x410110
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400459 <.text+0x119>
               	leaq	0xfcb0(%rip), %r12      # 0x410110
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x40, %r9d
               	movslq	%r9d, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4008bd <malloc>
               	movq	%rax, (%rbx)
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %rax
               	cmpq	$0x0, %rax
               	jne	0x4004f7 <.text+0x1b7>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x400503 <.text+0x1c3>
               	movslq	-0x10(%rbp), %r12
               	cmpq	$0x4, %r12
               	jge	0x40053f <.text+0x1ff>
               	jmp	0x400534 <.text+0x1f4>
               	leaq	-0x10(%rbp), %r12
               	movslq	(%r12), %rax
               	movq	%rax, %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%r12)
               	jmp	0x400503 <.text+0x1c3>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x18(%rbp)
               	jmp	0x40054b <.text+0x20b>
               	xorq	%r12, %r12
               	movl	%r12d, -0x10(%rbp)
               	jmp	0x4005cb <.text+0x28b>
               	movslq	-0x18(%rbp), %rbx
               	cmpq	$0x8, %rbx
               	jge	0x4005c6 <.text+0x286>
               	jmp	0x40057a <.text+0x23a>
               	leaq	-0x18(%rbp), %rbx
               	movslq	(%rbx), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rbx)
               	jmp	0x40054b <.text+0x20b>
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %rax
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %rbx
               	shlq	$0x4, %rbx
               	movq	%rax, %rdi
               	addq	%rbx, %rdi
               	movslq	-0x18(%rbp), %rbx
               	movq	%rbx, %rax
               	shlq	$0x1, %rax
               	movq	%rdi, %rsi
               	addq	%rax, %rsi
               	movl	$0x64, %eax
               	imulq	%r12, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	addq	%rbx, %r12
               	movslq	%r12d, %r12
               	movswq	%r12w, %r12
               	movw	%r12w, (%rsi)
               	jmp	0x400561 <.text+0x221>
               	jmp	0x400519 <.text+0x1d9>
               	movslq	-0x10(%rbp), %r12
               	cmpq	$0x4, %r12
               	jge	0x400607 <.text+0x2c7>
               	jmp	0x4005fc <.text+0x2bc>
               	leaq	-0x10(%rbp), %r12
               	movslq	(%r12), %rax
               	movq	%rax, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r12)
               	jmp	0x4005cb <.text+0x28b>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x18(%rbp)
               	jmp	0x400639 <.text+0x2f9>
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rax
               	movabsq	$-0x1, %rdi
               	movw	%di, (%rax)
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %rdi
               	movswq	(%rdi), %r12
               	cmpq	$-0x1, %r12
               	je	0x40072f <.text+0x3ef>
               	jmp	0x40070c <.text+0x3cc>
               	movslq	-0x18(%rbp), %rsi
               	cmpq	$0x8, %rsi
               	jge	0x4006bd <.text+0x37d>
               	jmp	0x400668 <.text+0x328>
               	leaq	-0x18(%rbp), %rsi
               	movslq	(%rsi), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rsi)
               	jmp	0x400639 <.text+0x2f9>
               	leaq	-0x8(%rbp), %r12
               	movq	(%r12), %rax
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %rsi
               	shlq	$0x4, %rsi
               	movq	%rax, %rbx
               	addq	%rsi, %rbx
               	movslq	-0x18(%rbp), %rsi
               	movq	%rsi, %rax
               	shlq	$0x1, %rax
               	movq	%rbx, %rdi
               	addq	%rax, %rdi
               	movswq	(%rdi), %rax
               	movl	$0x64, %edi
               	imulq	%r12, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r12
               	addq	%rsi, %r12
               	movslq	%r12d, %r12
               	movswq	%r12w, %r12
               	cmpq	%r12, %rax
               	je	0x400707 <.text+0x3c7>
               	jmp	0x4006c2 <.text+0x382>
               	jmp	0x4005e1 <.text+0x2a1>
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r12
               	addq	$0xa, %r12
               	movslq	%r12d, %r12
               	movslq	-0x18(%rbp), %rdi
               	movq	%r12, %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	0x40064f <.text+0x30f>
               	movl	$0x63, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x4008c3 <free>
               	movslq	%eax, %rax
               	leaq	0xfa16(%rip), %r12      # 0x410160
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x4008c9 <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
