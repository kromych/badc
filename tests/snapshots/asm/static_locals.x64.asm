
static_locals.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400304 <.text+0xd4>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	leaq	0xfe92(%rip), %r11      # 0x4100e0
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	movslq	%edi, %r11
               	cmpq	$0x0, %r11
               	je	0x400294 <.text+0x64>
               	leaq	0xfe6f(%rip), %r9       # 0x4100e8
               	movl	$0x64, %r11d
               	movl	%r11d, (%r9)
               	leaq	0xfe67(%rip), %r8       # 0x4100f0
               	xorq	%r11, %r11
               	movl	%r11d, (%r8)
               	jmp	0x400294 <.text+0x64>
               	leaq	0xfe4d(%rip), %r11      # 0x4100e8
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	leaq	0xfe3e(%rip), %r8       # 0x4100f0
               	movslq	(%r8), %r9
               	movslq	(%r11), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r8)
               	movslq	(%r11), %rdi
               	movslq	(%r8), %r11
               	addq	%r11, %rdi
               	movslq	%edi, %rax
               	retq
               	leaq	0xfe23(%rip), %r11      # 0x4100f8
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	leaq	0xfe10(%rip), %r11      # 0x410100
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	callq	0x400247 <.text+0x17>
               	cmpq	$0x1, %rax
               	je	0x400347 <.text+0x117>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x400247 <.text+0x17>
               	cmpq	$0x2, %rax
               	je	0x400377 <.text+0x147>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x400247 <.text+0x17>
               	cmpq	$0x3, %rax
               	je	0x4003a7 <.text+0x177>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	0x400262 <.text+0x32>
               	cmpq	$0xca, %rax
               	je	0x4003dc <.text+0x1ac>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	0x400262 <.text+0x32>
               	cmpq	$0x131, %rax            # imm = 0x131
               	je	0x400412 <.text+0x1e2>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	0x400262 <.text+0x32>
               	cmpq	$0xca, %rax
               	je	0x40044a <.text+0x21a>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002ce <.text+0x9e>
               	cmpq	$0x1, %rax
               	je	0x400479 <.text+0x249>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002ce <.text+0x9e>
               	cmpq	$0x2, %rax
               	je	0x4004a9 <.text+0x279>
               	movl	$0x8, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002e9 <.text+0xb9>
               	cmpq	$0x3e9, %rax            # imm = 0x3E9
               	je	0x4004d8 <.text+0x2a8>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002e9 <.text+0xb9>
               	cmpq	$0x3ea, %rax            # imm = 0x3EA
               	je	0x400508 <.text+0x2d8>
               	movl	$0xa, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002ce <.text+0x9e>
               	cmpq	$0x3, %rax
               	je	0x400538 <.text+0x308>
               	movl	$0xb, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
