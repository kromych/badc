
libc_data_globals.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400490 <.text+0x150>
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
               	callq	0x4007e7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40045c <.text+0x11c>
               	leaq	0xfccc(%rip), %r14      # 0x410110
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40045c <.text+0x11c>
               	leaq	0xfcad(%rip), %r12      # 0x410110
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	xorq	%r15, %r15
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rdi
               	cmpq	$0x0, %r12
               	jne	0x400512 <.text+0x1d2>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x0, %rbx
               	jne	0x400546 <.text+0x206>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x0, %rdi
               	jne	0x40057a <.text+0x23a>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbdf(%rip), %r14      # 0x410160
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x4007ed <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	jge	0x4005c5 <.text+0x285>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb98(%rip), %r15      # 0x410164
               	movl	$0x1, %r14d
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4007f3 <fputs>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	jge	0x400625 <.text+0x2e5>
               	movl	$0x5, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xfb32(%rip), %r14      # 0x41016e
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4007f9 <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	jge	0x400684 <.text+0x344>
               	movl	$0x6, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
