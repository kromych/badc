
comma_operator_in_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003e8 <.text+0x168>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
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
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
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
               	callq	0x400707 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400399 <.text+0x119>
               	leaq	0xfd77(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400399 <.text+0x119>
               	leaq	0xfd58(%rip), %r12      # 0x4100f8
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
               	movslq	%edi, %rax
               	leaq	0xfd71(%rip), %r9       # 0x410148
               	movslq	(%r9), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x400411 <.text+0x191>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0xa, %r8
               	movl	%r8d, (%r11)
               	jmp	0x40042a <.text+0x1aa>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	0x4003cd <.text+0x14d>
               	cmpq	$0x0, %rbx
               	jne	0x400411 <.text+0x191>
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	0x4003cd <.text+0x14d>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	je	0x40047a <.text+0x1fa>
               	leaq	-0x10(%rbp), %r12
               	movslq	(%r12), %rax
               	movq	%rax, %r11
               	addq	$0x64, %r11
               	movl	%r11d, (%r12)
               	jmp	0x40047a <.text+0x1fa>
               	movl	$0x7, %ebx
               	movq	%rbx, %rdi
               	callq	0x4003cd <.text+0x14d>
               	movl	$0x2, %eax
               	jmp	0x4004e4 <.text+0x264>
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	0x400503 <.text+0x283>
               	leaq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	0x400491 <.text+0x211>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r12
               	movq	%r12, %rbx
               	addq	$0x3e8, %rbx            # imm = 0x3E8
               	movl	%ebx, (%rax)
               	jmp	0x400491 <.text+0x211>
               	leaq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x1869f, %rax          # imm = 0x1869F
               	movl	%eax, (%rbx)
               	jmp	0x400491 <.text+0x211>
               	cmpq	$0x1, %rax
               	je	0x40049c <.text+0x21c>
               	cmpq	$0x2, %rax
               	je	0x4004b4 <.text+0x234>
               	jmp	0x4004cc <.text+0x24c>
               	xorq	%r14, %r14
               	movq	%r14, %rdi
               	callq	0x4003cd <.text+0x14d>
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	0x400554 <.text+0x2d4>
               	jmp	0x40053c <.text+0x2bc>
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r14
               	movq	%r14, %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%rax)
               	jmp	0x400503 <.text+0x283>
               	leaq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %r14
               	movq	%r14, %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	0x400524 <.text+0x2a4>
               	leaq	0xfbed(%rip), %rax      # 0x410148
               	movslq	(%rax), %r14
               	cmpq	$0x7, %r14
               	je	0x40058e <.text+0x30e>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %r14
               	subq	$0x456, %r14            # imm = 0x456
               	movslq	%r14d, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
