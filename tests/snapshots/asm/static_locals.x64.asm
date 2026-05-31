
static_locals.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400316 <.text+0xe6>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	leaq	0xfe92(%rip), %r11      # 0x4100e0
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	movslq	%edi, %r11
               	cmpq	$0x0, %r11
               	je	0x400297 <.text+0x67>
               	leaq	0xfe6c(%rip), %r9       # 0x4100e8
               	movl	$0x64, %r11d
               	movl	%r11d, (%r9)
               	leaq	0xfe64(%rip), %r8       # 0x4100f0
               	xorq	%r11, %r11
               	movl	%r11d, (%r8)
               	jmp	0x400297 <.text+0x67>
               	leaq	0xfe4a(%rip), %r11      # 0x4100e8
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	leaq	0xfe38(%rip), %r9       # 0x4100f0
               	movslq	(%r9), %r8
               	movslq	(%r11), %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%r9)
               	movslq	(%r11), %rdi
               	movslq	(%r9), %r11
               	movq	%rdi, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	leaq	0xfe17(%rip), %r11      # 0x4100f8
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	leaq	0xfe01(%rip), %r11      # 0x410100
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	movslq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	callq	0x400247 <.text+0x17>
               	cmpq	$0x1, %rax
               	je	0x400359 <.text+0x129>
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
               	je	0x400389 <.text+0x159>
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
               	je	0x4003b8 <.text+0x188>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	0x400265 <.text+0x35>
               	cmpq	$0xca, %rax
               	je	0x4003ed <.text+0x1bd>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	0x400265 <.text+0x35>
               	cmpq	$0x131, %rax            # imm = 0x131
               	je	0x400422 <.text+0x1f2>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	0x400265 <.text+0x35>
               	cmpq	$0xca, %rax
               	je	0x40045a <.text+0x22a>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002da <.text+0xaa>
               	cmpq	$0x1, %rax
               	je	0x400489 <.text+0x259>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002da <.text+0xaa>
               	cmpq	$0x2, %rax
               	je	0x4004b9 <.text+0x289>
               	movl	$0x8, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002f8 <.text+0xc8>
               	cmpq	$0x3e9, %rax            # imm = 0x3E9
               	je	0x4004e8 <.text+0x2b8>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002f8 <.text+0xc8>
               	cmpq	$0x3ea, %rax            # imm = 0x3EA
               	je	0x400518 <.text+0x2e8>
               	movl	$0xa, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002da <.text+0xaa>
               	cmpq	$0x3, %rax
               	je	0x400547 <.text+0x317>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
