
variadic_sprintf.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4004cd <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfd71(%rip)           # 0x410108
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd5e(%rip), %r9       # 0x410118
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40040b <.text+0x8b>
               	leaq	0xfd3a(%rip), %rdi      # 0x410118
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
               	leaq	0xfd17(%rip), %rdi      # 0x410130
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd05(%rip), %rsi      # 0x410136
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfcf4(%rip), %r9       # 0x41013d
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
               	callq	0x400747 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400499 <.text+0x119>
               	leaq	0xfc97(%rip), %r14      # 0x410118
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400499 <.text+0x119>
               	leaq	0xfc78(%rip), %r12      # 0x410118
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
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x40, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x40074d <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xfc5f(%rip), %r14      # 0x410168
               	movl	$0xb, %ebx
               	movl	$0x16, %r15d
               	movl	$0x21, %r10d
               	movq	%r10, 0x20(%rsp)
               	movl	$0x2c, %r12d
               	movq	%r14, %rsi
               	movq	%r12, %r9
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	0x28(%rsp), %rdi
               	movq	0x20(%rsp), %r8
               	movb	$0x0, %al
               	callq	0x400753 <sprintf>
               	movslq	%eax, %rax
               	movslq	%eax, %r12
               	cmpq	$0xb, %r12
               	je	0x40057d <.text+0x1fd>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbf0(%rip), %r14      # 0x410174
               	movl	$0xb, %ebx
               	movq	%r14, %rsi
               	movq	%rbx, %rdx
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x400759 <memcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x4005d2 <.text+0x252>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x40075f <free>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
