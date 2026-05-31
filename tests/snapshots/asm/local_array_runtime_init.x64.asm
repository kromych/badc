
local_array_runtime_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400705 <.text+0x485>
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
               	callq	0x400b87 <dlsym>
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	leaq	-0x8(%rbp), %r9
               	leaq	0x10162(%rip), %r8      # 0x410548
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
               	movq	%r9, %rdi
               	leaq	0xfd34(%rip), %rdi      # 0x410148
               	movq	%r11, %r8
               	shlq	$0x1, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movzwq	(%r9), %r8
               	leaq	-0x8(%rbp), %r9
               	movw	%r8w, (%r9)
               	leaq	0xff14(%rip), %rdi      # 0x410348
               	movq	%r11, %r9
               	shlq	$0x1, %r9
               	movq	%rdi, %r11
               	addq	%r9, %r11
               	movzwq	(%r11), %r9
               	leaq	-0x8(%rbp), %r11
               	movq	%r11, %rdi
               	addq	$0x2, %rdi
               	movw	%r9w, (%rdi)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %rdi
               	movl	$0x3e8, %r11d           # imm = 0x3E8
               	imulq	%rdi, %r11
               	movslq	%r11d, %r11
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r9
               	addq	$0x2, %r9
               	movzwq	(%r9), %rdi
               	movq	%r11, %r9
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	leaq	-0x10(%rbp), %r8
               	leaq	0x100a0(%rip), %rdi     # 0x41054c
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
               	movq	%r8, %rsi
               	movq	%r11, %rsi
               	addq	%r9, %rsi
               	movslq	%esi, %rsi
               	leaq	-0x10(%rbp), %rdi
               	movl	%esi, (%rdi)
               	movq	%r11, %r8
               	subq	%r9, %r8
               	movslq	%r8d, %r8
               	leaq	-0x10(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x4, %rsi
               	movl	%r8d, (%rsi)
               	movq	%r11, %rdi
               	imulq	%r9, %rdi
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x8, %r11
               	movl	%edi, (%r11)
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r11
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %rdi
               	addq	$0x4, %rdi
               	movslq	(%rdi), %r9
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r9
               	movq	%rdi, %r11
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	leaq	-0x10(%rbp), %r8
               	leaq	0xffd9(%rip), %rdi      # 0x410558
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%r8)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%r8)
               	popq	%rax
               	movq	%r8, %rsi
               	movq	%r11, %rsi
               	addq	%r9, %rsi
               	leaq	-0x10(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	movq	%r11, %r8
               	subq	%r9, %r8
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x8, %r11
               	movq	%r8, (%r11)
               	leaq	-0x10(%rbp), %r9
               	movq	(%r9), %r11
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x8, %r8
               	movq	(%r8), %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %r11
               	leaq	-0x8(%rbp), %r9
               	leaq	0xff6f(%rip), %r8       # 0x410568
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
               	movq	%r9, %rdi
               	movq	%r11, %rdi
               	addq	$0x61, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r8
               	andq	$0xff, %r8
               	leaq	-0x8(%rbp), %rdi
               	movb	%r8b, (%rdi)
               	movl	$0x62, %r9d
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x1, %r8
               	movb	%r9b, (%r8)
               	movq	%r11, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r11
               	andq	$0xff, %r11
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x2, %r8
               	movb	%r11b, (%r8)
               	movl	$0x64, %edi
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x3, %r11
               	movb	%dil, (%r11)
               	xorq	%r8, %r8
               	movl	%r8d, -0x10(%rbp)
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x4006a3 <.text+0x423>
               	movslq	-0x18(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	0x4006f8 <.text+0x478>
               	jmp	0x4006d2 <.text+0x452>
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r11
               	movq	%r11, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r8)
               	jmp	0x4006a3 <.text+0x423>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r11
               	leaq	-0x8(%rbp), %r8
               	movslq	-0x18(%rbp), %r9
               	movq	%r8, %rsi
               	addq	%r9, %rsi
               	movzbq	(%rsi), %r9
               	movq	%r11, %rsi
               	addq	%r9, %rsi
               	movl	%esi, (%rdi)
               	jmp	0x4006b9 <.text+0x439>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	0xfa23(%rip), %r11      # 0x410148
               	movq	%r11, %r9
               	addq	$0xa, %r9
               	movl	$0x1234, %r11d          # imm = 0x1234
               	movw	%r11w, (%r9)
               	leaq	0xfc08(%rip), %r8       # 0x410348
               	movq	%r8, %r11
               	addq	$0xa, %r11
               	movl	$0x5678, %r8d           # imm = 0x5678
               	movw	%r8w, (%r11)
               	movl	$0x5, %ebx
               	movq	%rbx, %rdi
               	callq	0x4003cd <.text+0x14d>
               	movl	$0x471b20, %ebx         # imm = 0x471B20
               	movslq	%ebx, %rbx
               	movq	%rbx, %r11
               	addq	$0x5678, %r11           # imm = 0x5678
               	movslq	%r11d, %r11
               	cmpq	%r11, %rax
               	je	0x4007a2 <.text+0x522>
               	movl	$0x1, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r12d
               	movl	$0x4, %ebx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	0x400490 <.text+0x210>
               	cmpq	$0x12, %rax
               	je	0x4007e7 <.text+0x567>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r14d
               	movl	$0x4, %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400563 <.text+0x2e3>
               	cmpq	$0x14, %rax
               	je	0x40082c <.text+0x5ac>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x4005e0 <.text+0x360>
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	0x400869 <.text+0x5e9>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	leaq	0xfcf8(%rip), %rax      # 0x41056c
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r12)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r12)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r12)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r12)
               	popq	%r11
               	movq	%r12, %r14
               	leaq	-0x10(%rbp), %r14
               	movslq	(%r14), %rax
               	leaq	-0x10(%rbp), %r14
               	movq	%r14, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %r14
               	movq	%rax, %r12
               	addq	%r14, %r12
               	movslq	%r12d, %r12
               	leaq	-0x10(%rbp), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r14
               	movq	%r12, %rax
               	addq	%r14, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	0x400915 <.text+0x695>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r14
               	leaq	0xfc5e(%rip), %rax      # 0x41057e
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r14)
               	popq	%r11
               	movq	%r14, %r12
               	leaq	-0x18(%rbp), %r12
               	movzbq	(%r12), %rax
               	movq	%rax, %r12
               	xorq	$0x68, %r12
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	cmpq	$0x0, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x28(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x4009a5 <.text+0x725>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x4, %r12
               	movzbq	(%r12), %rax
               	movq	%rax, %r12
               	xorq	$0x6f, %r12
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	cmpq	$0x0, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x28(%rbp)
               	jmp	0x4009a5 <.text+0x725>
               	movq	-0x28(%rbp), %r12
               	movq	%r12, -0x20(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x4009ee <.text+0x76e>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x5, %r12
               	movzbq	(%r12), %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	cmpq	$0x0, %r12
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x20(%rbp)
               	jmp	0x4009ee <.text+0x76e>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400a22 <.text+0x7a2>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
